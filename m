Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Support for stored link keys
References: <1114094787.32265.11.camel@pegasus> <Pine.LNX.4.61.0504211823390.16740@cherokee.spacecom.si> <1114101950.32265.40.camel@pegasus>
In-Reply-To: <1114101950.32265.40.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504242012.10067.bluez-devel@schaettgen.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 24 Apr 2005 20:12:09 +0200

On Thursday, 21. April 2005 18:45, Marcel Holtmann wrote:
> > > The Widcomm stack stores it somewhere in the Registry and actually I
> > > like to see a program that can read these keys from the Registry if the
> > > Windows root partition is mounted. Anyone?
> >
> > This would be cool :)
>
> Exists any tool or library that allows to read the Windows registry
> directly from Linux if the filesystem is mounted?

What I tried a while ago was to export BlueZ link keys to reuse them with 
Microsoft's bluetooth stack. The idea was to write a .inf-file under Linux, 
which can later be applied under windows to put the link key into the 
registry. IIRC it was basically working, but I didn't include into the KDE 
link key manager so far, because I had to change permission of some keys and 
I didn't know how to do that in an inf file. 
The same approach should work for the Widcomm stack, too. It's not fully 
automatic, but it would be flexible and safe.
It should also be easy to write a small windows tool to extract the contents 
of the windows bluetooth stack to use it with BlueZ. Extracting it directly 
under Linux would be more efficient, but I don't think it's worth the effort. 
It won't hurt much if windows had to be started to transfer link keys. It's 
meant for Windows/Linux dual boot users anyway.

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
