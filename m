Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred =?utf-8?q?Sch=C3=A4ttgen?= <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] non-blocking device discovery
References: <1073308932.26243.1058.camel@baroque.rococosoft.com>
In-Reply-To: <1073308932.26243.1058.camel@baroque.rococosoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200401052012.34307.bluez-devel@schaettgen.de>
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
Date: Mon, 5 Jan 2004 20:12:34 +0100

On Monday 05 January 2004 14:22, Stephen Crane wrote:
> Hi,
> I seem to remember a posting to this list in which someone mentioned
> that they'd implemented non-blocking device-discovery by writing
> commands directly to the hci socket. The code was C++ which leads me to
> think that it was part of KDE but I can't find it on the net.
>
> Can someone refresh my memory?

Maybe you were looking for this: http://cvs.sourceforge.net/viewcvs.py/
kde-bluetooth/kdebluetooth/libkbluetooth/? It's not part of the official KDE 
distribution (yet), but it's in fact KDE/Qt code..

greetings
Fred



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
