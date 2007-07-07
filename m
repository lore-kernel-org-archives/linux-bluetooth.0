Return-Path: <clameter@sgi.com>
Date: Sat, 7 Jul 2007 16:07:15 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>,
        Patrick Caulfield <pcaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        bluez-devel@lists.sourceforge.net,
        Marcel Holtmann <marcel@holtmann.org>, Jiri Kosina <jkosina@suse.cz>,
        Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: 2.6.22-rc7: known regressions with patches v2
In-Reply-To: <6bffcb0e0707070959m12ba9b66n8587605eb1f6c21e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0707071557160.16503@schroedinger.engr.sgi.com>
References: <468FBA20.8060509@googlemail.com>  <1183825391.3066.59.camel@shinybook.infradead.org>
 <6bffcb0e0707070959m12ba9b66n8587605eb1f6c21e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Sat, 7 Jul 2007, Michal Piotrowski wrote:

> > If you're looking for someone to blame, consider the fact that this has
> > gone away now I've switched back to slab. :)
> Yup, I forgot to add Christoph to CC  :)

Hmmmm.. Cannot see the corruption in the dump since it only includes 128 
bytes and it seems to have occurred way into the object. If you want to 
dump 32k to your syslog to see the corruption then look at the 
print_trailer() function and change the parameter of the call to 
print_section

	print_section("Object", p, min(s->objsize, 128));


This is a 32k sized slab and SLAB does not allow debugging on power of two 
slabs > pagesize.... No surprise that SLAB does not complain.

What are these functions "malloc" and "free"? Would be good if those 
would be using kmalloc_track_caller() so that we can figure out who called 
them.
