Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Christoph Lukas <christoph.lukas@gmx.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44970CBD.8000802@xmission.com>
References: <1150746967.5012.13.camel@localhost>
	<44970CBD.8000802@xmission.com>
Content-Type: multipart/mixed; boundary="=-gpVSquPRUXYqsO0m3Oye"
Date: Tue, 20 Jun 2006 16:30:44 +0200
Message-Id: <1150813845.3345.14.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Slow connection to Motorola H500 Headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--=-gpVSquPRUXYqsO0m3Oye
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Brad,

thanks for your quick reply.

> > Audio transfer is working perfectly in both directions, the only minor
> > annoyance is that it takes several seconds for every connection to be
> > established.
> 
> maybe the headset is parking itself between connections. I don't know
> much about what can be done to influence its policy though.

It seems as if the headset enters some kind of 'powersave' mode after a
few seconds.


> you could start up hcidump before you bring up the headset and tell us
> what the dump looks like at the start. we might be able to tell what
> slows things down.

I did the following steps to produce the two attached hcidumps:

hcidump-fast.gz:
* start hcidump
* switch headset on
* wait for link key request and immediately start btsco
* wait for btsco to be ready and immediately start aplay
=> This results in an immediately starting audio playback

hcidump-slow.gz:
* start hcidump
* switch headset on
* wait for link key request and immediately start btsco
* wait about 30 sec. after btsco being ready before starting aplay
=> This results in an delay of 3-5 seconds before audio playback is
starting

This behaviour is reproducable.

If anybody has any hints what is happening here that would be great.

Thanks in advance,
Christoph



--=-gpVSquPRUXYqsO0m3Oye
Content-Disposition: attachment; filename=hcidump-fast.gz
Content-Type: application/x-gzip; name=hcidump-fast.gz
Content-Transfer-Encoding: base64

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


--=-gpVSquPRUXYqsO0m3Oye
Content-Disposition: attachment; filename=hcidump-slow.gz
Content-Type: application/x-gzip; name=hcidump-slow.gz
Content-Transfer-Encoding: base64

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


--=-gpVSquPRUXYqsO0m3Oye
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-gpVSquPRUXYqsO0m3Oye
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-gpVSquPRUXYqsO0m3Oye--
