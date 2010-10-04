Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1286027890.12944.1.camel@localhost.localdomain>
References: <20100920184943.GA22968@jh-x301>
	<1286027890.12944.1.camel@localhost.localdomain>
Date: Mon, 4 Oct 2010 13:00:21 +0300
Message-ID: <AANLkTikFrvyeoXV0uLYcvD4GCj2s3ML2-q8f5GhXMxAK@mail.gmail.com>
Subject: Re: >net-wireless/bluez-4.63 unable to connect audio streams due commit
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: pacho@condmat1.ciencias.uniovi.es
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Oct 2, 2010 at 4:58 PM, Pacho Ramos
<pacho@condmat1.ciencias.uniovi.es> wrote:
> El lun, 20-09-2010 a las 21:49 +0300, Johan Hedberg escribió:
>> Hi,
>>
>> On Mon, Sep 20, 2010, Pacho Ramos wrote:
>> > Reporter found that the problem with his dongle was introduced in commit
>> > aee26b30bbc24cde464ba1a557c2b258ddec6432 "Make BtIO default security
>> > level MEDIUM", he asked here, on upstream mailing list, but didn't get
>> > any reply clarifying this:
>> > http://marc.info/?l=linux-bluetooth&m=127893935109510&w=2
>>
>> The important piece of info missing here is an HCI trace of the failure
>> (i.e. output of hcidump). There was a similar issue reported on IRC a
>> few days back and the hcidump there revealed a LMP response timeout
>> after BlueZ issues a HCI_Set_Connection_Encryption command. This would
>> seem to indicate a bug either in the local adapter or the remote device
>> (headset). Only an airtrace would really reveal what's going on.
>> However, I suspect it might be possible to work around this by looking
>> into possibilities of changing the ordering and timing of when the
>> kernel sends the encryption request.
>>
>> Johan
>>
>
> Sorry for the delay but downstream reporter wasn't able to provide the
> information sooner.
>
> Attached is hcidump output, I hope it helps :-)

I would say this was because of double authentication request, but it
seems it is not the case, actually ssp doesn't seems to be used at all
here so this must be something else, maybe you should try this:

http://thread.gmane.org/gmane.linux.bluez.kernel/7256

-- 
Luiz Augusto von Dentz
Computer Engineer
