Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] scooped by pocketpc (a2dp)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41F4A55D.9070701@xmission.com>
References: <41E93682.9040907@xmission.com>
	 <41E93B4F.1010600@dark-reality.de> <41EA1B6E.3070303@xmission.com>
	 <41F4A55D.9070701@xmission.com>
Content-Type: text/plain
Message-Id: <1106569711.9269.73.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 24 Jan 2005 13:28:31 +0100

Hi Brad,

> I noticed that linphone from debian-testing has oss and alsa devices in 
> its audio device selection menu.
> 
> I still haven't been able to get the stubbed out alsa-lib driver to show 
> up! I also tried a .asoundrc with
> 
> pcm.a2dpplug {
>          type plug
>          slave { pcm "a2dp" }
> }
> 
> pcm.a2dp {
>          type a2dp
>          bdaddr "00:08:F4:30:05:BB"
> }
> 
> since that was more like what the jack plugin is supposed to have... no 
> luck...

the ALSA kernel drivers have an OSS emulation and so they will show up.
This is not possible for the ALSA library plugins.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
