Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <buez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Sharing link keys with windows?
References: <200410181951.02650.buez-devel@schaettgen.de> <1098122330.11765.10.camel@pegasus>
In-Reply-To: <1098122330.11765.10.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410182008.22134.buez-devel@schaettgen.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 18 Oct 2004 20:08:22 +0200

On Monday 18 October 2004 19:58, Marcel Holtmann wrote:
> Hi Fred,
>
> > If I switch between Windows and Linux I have to re-pair devices each time
> > I boot the other system and try to use a service that requires
> > authentication. Is there a utility to copy the link keys from Linux to
> > Windows, so that both BlueZ and the MS-Stack use the same keys?
>
> I don't know of any tools, but I think there was a discussion about that
> some time ago and it seems that the Widcomm stack is storing the link
> keys somewhere in the Windows registry.

So does the MS-Stack..
Then I'll go ahead and try it myself. If you don't know such a tool, then it 
doesn't exist I guess. Uhm, btw. you are not going to change the structure of 
the link_key file during the next weeks, do you?

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
