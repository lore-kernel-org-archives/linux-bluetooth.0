Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4490106D.30901@xmission.com>
Date: Wed, 14 Jun 2006 07:34:37 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <1150148335.7372.7.camel@johannes_01.kapune.local>	<448DEA20.5000806@stfw.eu>	<1150219383.7401.5.camel@johannes_01.kapune.local>	<448EFA00.3030000@xmission.com>
	<1150272891.7398.28.camel@johannes_01.kapune.local>
In-Reply-To: <1150272891.7398.28.camel@johannes_01.kapune.local>
Subject: Re: [Bluez-users] Can't play mp3, what I'm missing?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Johannes

> I'm not sure but I see in the "connection-display" that my headphone is
> master. Is this right or should it be slave?

fwiw, the itech r35 wouldn't allow a connection from my pc until i
changed hcid's link mode from

lm accept,master;

to

lm accept;

and restarted hcid. It may be because at the time the headset was also
connected to my cellphone... later on it didn't have this requirement.

headsets that can do a2dp and headset/handsfree may prefer or require
being master so they don't have to do a scatternet to communicate to two
devices at the same time.

brad




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
