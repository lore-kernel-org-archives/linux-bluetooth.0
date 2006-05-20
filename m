Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <446F383A.1040605@ens.fr>
From: Giuseppe Castagna <Giuseppe.Castagna@ens.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <446CDD43.3050604@free.fr>
In-Reply-To: <446CDD43.3050604@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] report on new bluez headset
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
Date: Sat, 20 May 2006 17:39:38 +0200

Hi Fabien,

    here you are a first report on your headset support. I have a Motorola HS850 
and use it in conjunction with a Thinkpad X40 with bluetooth-modem integrated 
adapter.

I have patched and compiled ekiga and selected the bluetooth headset device.
Everithing works fine in general (nice work) but:

- if I close and reopen the headset then ekiga no longer finds the audio device
- if I change the device in the preferences and then put back the
   bluetooth headset  ekiga no longer finds the bluetooth device.

In both cases the only solution is to close and reopen ekiga.

Woth xmms instad the beahviour is *quite* bizarre. When I select the headset in 
the alsa plugin the music is played about 4 times faster and the console prints 
repeatedly the following warning.

** WARNING **: alsa_mmap_audio(): snd_pcm_mmap_commit returned 24, expected 104

As soon as I change de device (e.g. to default) or pass to OSS then this weird 
behavior completely desappears and the song is played correctly.

I guess that you already know it but
- pressing the headset button has no visible effect
- the device does not appear in the alsa mixer

---Beppe---


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
