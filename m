Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F4A55D.9070701@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] scooped by pocketpc (a2dp)
References: <41E93682.9040907@xmission.com> <41E93B4F.1010600@dark-reality.de> <41EA1B6E.3070303@xmission.com>
In-Reply-To: <41EA1B6E.3070303@xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 24 Jan 2005 00:35:57 -0700

Lars

> hmm. i see a menu for alsa devices but our userspace a2dp device 
> (currently stubbed out, but not implemented) doesn't show up. i set it 
> up as documented in btsco/bt/BUILD
> 
>> That leads to - at least - gnomemeeting and openphone supporting alsa
>> directly :)

I noticed that linphone from debian-testing has oss and alsa devices in 
its audio device selection menu.

I still haven't been able to get the stubbed out alsa-lib driver to show 
up! I also tried a .asoundrc with

pcm.a2dpplug {
         type plug
         slave { pcm "a2dp" }
}

pcm.a2dp {
         type a2dp
         bdaddr "00:08:F4:30:05:BB"
}

since that was more like what the jack plugin is supposed to have... no 
luck...

Brad


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
