Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] doc: Add EIR to device properties
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+bD78jFNmMynTYaUXNgVZukbc6P1M5zELwCeudg=tM1W5BZYQ@mail.gmail.com>
Date: Tue, 1 Jul 2014 18:31:17 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F9E3F374-2026-42C0-B5F8-DCC3E82586FE@holtmann.org>
References: <1403897492-6233-1-git-send-email-scott@netsplit.com> <B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org> <CA+bD78j4bSfqvn7MHnsV7PKp_dGXN4dLApW2G5p4oN-Tsu+h1Q@mail.gmail.com> <F49C47A1-077C-41E2-A36B-3DE9EF1A9E19@holtmann.org> <CA+bD78j4RfvZdMoKLcfDdtsy1g_bgZ-vnbAOY80W_JcZDNuEyA@mail.gmail.com> <E324D0BB-4042-4E4F-8F14-16B09C34B259@holtmann.org> <724A0273-FB02-49DF-B286-4C3440C049F7@holtmann.org> <CA+bD78g+AU4VKq5qPLGBGQM1+2ciqVmm77VvETw2XmBV_cM=sQ@mail.gmail.com> <F66A2DC8-B724-4846-9B4C-81528365E854@holtmann.org> <CA+bD78jFNmMynTYaUXNgVZukbc6P1M5zELwCeudg=tM1W5BZYQ@mail.gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>>> The main missing SIG defined fields which don't have properties would be:
>>> 
>>> - TX Power (CSSv4 1.5)
>> 
>> we should do the proper math here and provide Pathloss when discovered (again, similar disappearance to RSSI).
>> 
> 
> We'd still need the RSSI property because certain existing peripherals
> are placing the TX Power in the manufacturer data, which means the app
> would have to calculate path loss itself.

the idea was not to remove RSSI property. The idea was to add Pathloss property additionally instead of just adding TX Power property.

> Is there a circumstance in which additional manuf data could make the
> path loss calculation more accurate?

No. The reason why iBeacons have them in the manufacturer data is that there is no space for the TX Power element.

>>> - URL (https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=287247)
>> 
>> Is that one new? Could be. That seems to be dead simple and can really just get its own property.
>> 
> 
> Yeah, some guys here are working on a prototype and sticking URLs in
> the name field ... Robin Heydon saw it and decided that was useful
> enough to declare a standard field for it.
> 
> Still at NWP, I don't think the CSWG has proposed assigned numbers
> changes yet, but worth keeping an eye on.

Becomes tricky size wise, but once it is official, we can easily support that one.

Regards

Marcel

