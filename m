Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4496B96C.4060207@xmission.com>
Date: Mon, 19 Jun 2006 08:49:16 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447C6278.1040707@palmsource.com>	<447C6598.6050107@xmission.com>	<447C69D4.9020504@palmsource.com>	<447C7330.9000303@xmission.com>
	<44963723.4040807@xmission.com> <44965944.6090908@palmsource.com>
In-Reply-To: <44965944.6090908@palmsource.com>
Subject: Re: [Bluez-devel] A2DP Profile Certification
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Fr=E9d=E9ric

>> This is how we find out a combo headset is taking a voice call.
>>  =

> I noticed that my headset stopped streaming when pressing the main =

> button and didn't get back playing after pressing the button again.
> Is that what you mean?

yes this should cover that scenario.

>> We're still missing something here... we don't listen for new control
>> connections from the set. You could look at a2recv.c for code that will
>> listen for new connections. This will be more complicated since you may
>> want to use dbus to start up the media player in response.
>>
> I was wondering how to generate such connections? Simply switch on the =

> headset? Any ideas?

the play button on an avrcp set? i was surprised to find when I ran
"sdptool add AVRTG" then avrecv that the play button did not cause the
set to connect to avrecv. maybe it's really trying to start up a one of
these plain a2dp connection (or maybe not doing anything :)

brad


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
