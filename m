Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Stephen Crane'" <steve.crane@rococosoft.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Message-ID: <000401c314b7$e8efb4a0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1052304997.1379.535.camel@baroque.rococosoft.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 7 May 2003 09:44:21 -0700

Hey Steve,

> >         1.) The SDP entry for the SDP server itself should have a 
> > Language Base Attribute ID List (because there are text 
> descriptions). 
> > I'm not absolutely clear on whether or not it is mandatory, but it 
> > would make the testers happy. Can an application add an 
> attribute to 
> > that record, or would sdpd have to be modified?
> 
> Should be fixed in CVS for sdpd. (However, I can't find out 
> how the ISO 639 language name, e.g., 'en', is mapped to a 
> UINT_16. I assumed 'e' is more significant.)

Great, thanks. I took a quick look and it appears that other people think
the 'e' is more significant too. So the 16-bit code that other devices use
is 0x656e.

> >         2.) There appears to be a problem handling continuation 
> > states. Handling continuation state is optional. We found 
> that if the 
> > querying device sends a maximum byte count of 100, the 
> continutation 
> > state worked fine. But if the querying device sent a maximum byte 
> > count of 8, the continuation state doesn't work (the 
> continuation flag 
> > wasn't recognized in the next packet). I can dig up an 
> example log if 
> > it would help.
> 
> Yeah it would be good to get a log. I imagine 8-bytes is 
> pretty close to the minimum size.

I'll forward the logs as soon as I get them.

We stumbled across this one accidentally. We didn't intend to test
continuation states. But apparently the real test for continuation states
uses a maximum byte count less than 8.

-Daryl.



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
