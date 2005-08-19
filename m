Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: John Gruenenfelder <johng@as.arizona.edu>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco - a few comments and a small .py script
Message-ID: <20050819204447.GA31631@as.arizona.edu>
References: <20050819193855.GA25514@uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050819193855.GA25514@uni-duesseldorf.de>
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
Date: Fri, 19 Aug 2005 13:44:47 -0700

On Fri, Aug 19, 2005 at 09:38:55PM +0200, Andreas Beck wrote:
>Q: I have used the same bluetooth dongle on different machines or with
>different machine configurations (e.g. using windows). Now my device
>will refuse to pair again with the dongle.
>
>A: Remove the line in /var/lib/bluetooth/[my-bdaddr]/linkkeys that is
>corresponding to the device that doesn't want to pair. BlueZ thinks it
>is already paired, but the Link-Key does not match.
>
>   I've seen a rather recent question that seems to be the same problem
>   on bluez-users. However the hints there point to
>   /etc/bluetooth/linkkeys - is this outdated or is this due to me using
>   debian packages?

This was my experience.  My device simply stopped working after I had used it
on another machine (same dongle though).  I am also using the Debian packages
and there is no /etc/bluetooth/linkkeys.

For me, the problem manifested itself as "input/output error" messages when
trying most bluetooth commands or btsco.  That's not a lot of help.

Eventually, somebody in my local users group tipped me off to the location of
the link keys as /var/lib/bluetooth and after deleting the offending files, my
headset could be paired again and it works now.

This seems, to me, to be a bug on both ends.

Bug 1) When you list the files in the Debian bluez packages,
/var/lib/bluetooth is not listed.  This is a clear packaging bug as that
directory should definitely be listed therein, even if the package doesn't
actually ship with any files *in* that directory (they are program
generated).

Bug 2) When the bluez tools (hcitool I think) are told to remove a key, they
do not do so.  That also made tracking down my problem harder.  Thinking it
was a key issue, the command to delete the key was given, but it didn't seem
to do anything.  Only manually deleting the file off the filesystem did the
trick.


-- 
--John Gruenenfelder    Research Assistant, Steward Observatory, U of Arizona
                        johng@as.arizona.edu
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
