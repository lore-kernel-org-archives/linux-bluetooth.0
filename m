Return-Path: <cyrus@holtmann.org>
From: <iarenaza@mondragon.edu> (=?utf-8?Q?I=C3=B1aki?= Arenaza)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth\@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] device: Some devices send HSP UUIDs in the wrong order
References: <1436823169-32164-1-git-send-email-iarenaza@mondragon.edu>
	<1436823169-32164-2-git-send-email-iarenaza@mondragon.edu>
	<CABBYNZL=y8K34DBsQJ3onFxFXNDUZ-6Qt_PWz_ok34e74C1=cA@mail.gmail.com>
Date: Tue, 14 Jul 2015 14:28:09 +0200
In-Reply-To: <CABBYNZL=y8K34DBsQJ3onFxFXNDUZ-6Qt_PWz_ok34e74C1=cA@mail.gmail.com>
	(Luiz Augusto von Dentz's message of "Tue, 14 Jul 2015 15:17:27
	+0300")
Message-ID: <87y4iily92.fsf@osgiliath.escomposlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 14 2015, Luiz Augusto von Dentz wrote:

Hi Luiz,

>> +               /* Fix devices that report HEADSET_HS_UUID before HSP_HS_UUID,
>> +                * contrary to what Erratum #3507 says.
>> +                */
>> +               if ((bt_uuid_strcmp(profile_uuid, HEADSET_HS_UUID) == 0)) {
>
> I guess we could stop right here and just assume it should be
> HSP_HS_UUID instead so you just have to free and use assign
> g_strdup(HSP_HS_UUID) to profile_uuid.

That was exactly what I did in my first (private) version of the
patch. But I wanted to play safe and make sure HSP_HS_UUID was also
there.

Frankly, I don't know how broken other devices are, as I don't deal with
Bluetooth on a regular basis. So I fully trust your judgement on this
:-)

Best regards,

-- 
Iñaki Arenaza

Electronics and Computing Department
Mondragon University – Faculty of Engineering
http://www.mondragon.edu/
Goiru kalea 2, 20500 Arrasate-Mondragon (Spain)
Tel: +34 647503750 (direct) / +34 943794700 (pbx)
