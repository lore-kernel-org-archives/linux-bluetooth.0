Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120828181041.GA7686@x220.sheraton.com>
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com>
	<1344870497-6929-2-git-send-email-rafal.garbat@tieto.com>
	<20120814095636.GA7055@x220>
	<20120828152058.GA18913@x220.sheraton.com>
	<503CE72D.2030501@tieto.com>
	<20120828165650.GA3165@x220.sheraton.com>
	<CAJdJm_PWn--HEsaex1zqL_CqEBvjKQXSABBnPeYP9CVKgeA6Wg@mail.gmail.com>
	<20120828181041.GA7686@x220.sheraton.com>
Date: Tue, 28 Aug 2012 14:23:22 -0400
Message-ID: <CAJdJm_NL5ALYLKcHJ7uzWdtgkC_72++58GWm=CRXea_YEaYcqg@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] Heart Rate Profile API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Garbat Rafal <rafal.garbat@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	Santiago Carot-Nemesio <sancane@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Aug 28, 2012 at 2:10 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> The registered "watcher" object will have different interface
>> depending on the profile. The application which will call
>> RegisterWatcher() needs to check that the device supports the expected
>> GATT service (e.g. by checking the "UUIDs" property of that device
>> object) before using the  org.bluez.HeartRate interface, therefore
>> IMHO it makes sense to have RegisterWatcher() on the device object
>> path.
>
> I'm not quite following. You'd still have per-profile interfaces on the
> adapter path.

What I meant, is that, before using RegisterWatcher(), you need to
check the "UUIDs" property on the device path. So you still need to
either enumerate all device objects and read their "UUIDs" property,
or monitor the "PropertiesChanged" signal (once the new Property API
is upstream).

So IMHO ff you need to access the device object, there is no gain in
moving the method to adapter object.

>> Unless you are proposing a generic Watcher API that could somehow be
>> shared by all profiles (including a single shared interface for the
>> watcher object)? How to represent data from profiles which are not
>> "measurement" based?
>
> I suppose you were directing this at Rafal and not me? I don't think it
> makes sense to merge these. I was only saying that the interfaces should
> go from Device to Adapter.

No, I was commenting specifically on your suggestion to move
RegisterWatcher() to the adapter path and have a "device" parameter to
select the device. The user of this API would still need to check if
the device actually supports that wanted GATT service (using the UUIDs
device property) before registering any watcher.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
