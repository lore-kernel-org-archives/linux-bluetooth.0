Return-Path: <steve.crane@rococosoft.com>
Subject: Re: [Bluez-devel] Cleaning up after sdp_get_access_protos()
From: Stephen Crane <steve.crane@rococosoft.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1109579551.17256.27.camel@pegasus>
References: <001401c51b9d$4c81af30$1a01010a@baked>
	 <1109579551.17256.27.camel@pegasus>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 11:59:01 +0000
Message-Id: <1109591941.23661.125.camel@baroque.rococosoft.com>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel, Daryl,

Daryl is correct. I have committed his fix to CVS.

For future reference, valgrind is a big help for this sort of thing. (If
your platform isn't x86, if you run your program on x86 it can show up
errors, even if they're benign on x86, if you see what I mean.)

% valgrind --tool=memcheck --leak-check=yes sdptool browse local

#before:
[...]
==14571== 8 bytes in 1 blocks are definitely lost in loss record 2 of 3
==14571==    at 0x1B904A90: malloc (vg_replace_malloc.c:131)
==14571==    by 0x1B92AAF1: sdp_list_append
(in /usr/lib/libbluetooth.so.1.0.10)
==14571==    by 0x1B92AE0E: sdp_get_access_protos
(in /usr/lib/libbluetooth.so.1.0.10)
==14571==    by 0x804A082: print_service_attr (in /usr/bin/sdptool)
==14571==
==14571== LEAK SUMMARY:
==14571==    definitely lost: 8 bytes in 1 blocks.
==14571==    possibly lost:   0 bytes in 0 blocks.
==14571==    still reachable: 24 bytes in 2 blocks.
==14571==         suppressed: 0 bytes in 0 blocks.

#after:
[...]
==15613== LEAK SUMMARY:
==15613==    definitely lost: 0 bytes in 0 blocks.
==15613==    possibly lost:   0 bytes in 0 blocks.
==15613==    still reachable: 16 bytes in 1 blocks.
==15613==         suppressed: 0 bytes in 0 blocks.

Thanks,
Steve

On Mon, 2005-02-28 at 09:32 +0100, Marcel Holtmann wrote:
> Hi Daryl,
> 
> > This stuff hurts my brain, so I was hoping someone (Marcel? ;) could verify
> > my logic.
> > 
> > I'm mentioning this mostly because the utils code gets used as example code.
> > 
> > In this snippet from sdptool.c, proto is cleaned up with
> > sdp_list_free(proto, (sdp_free_func_t)sdp_data_free);
> > 
> >         if (sdp_get_access_protos(rec, &proto) == 0) {
> >                 printf("Protocol Descriptor List:\n");
> >                 sdp_list_foreach(proto, print_access_protos, 0);
> >                 sdp_list_free(proto, (sdp_free_func_t)sdp_data_free);
> >         }
> > 
> > I think the cleanup should be:
> > 
> >     sdp_list_foreach(proto,(sdp_list_func_t)sdp_list_free,0);
> >     sdp_list_free(proto,0);
> > 
> > Looking at sdp.c source (in libs), sdp_get_access_protos() returns a list of
> > lists of data sequences. The data sequences themselves shouldn't be freed at
> > this point because they weren't allocated by sdp_get_access_protos() (thus
> > the ,0 in the sdp_list_foreach call). But the list of lists is allocated
> > inside sdp_get_access_protos().
> 
> actually I have no idea, because I didn't wrote this code.
> 
> Steve, any thoughts?
> 
> Regards
> 
> Marcel
> 
> 
