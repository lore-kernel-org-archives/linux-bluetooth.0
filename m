Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHF=Y4r9ua3W0=kfbL6=3K+xxGda61gn2e8fb9P-1vzUQjTeOw@mail.gmail.com>
References: <1413200623-31278-1-git-send-email-fons@spotify.com>
 <1413200623-31278-3-git-send-email-fons@spotify.com> <20141013161319.GA27533@t440s.P-661HNU-F1>
 <CAHF=Y4r9ua3W0=kfbL6=3K+xxGda61gn2e8fb9P-1vzUQjTeOw@mail.gmail.com>
From: Alfonso Acosta <fons@spotify.com>
Date: Tue, 14 Oct 2014 14:48:43 +0200
Message-ID: <CAHF=Y4pHcAfLk4RStdbRGkF_s34CbzPuCf+5dcfWRt6OuUPmOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] core: Add Manufacturer Specific Data EIR field
To: Alfonso Acosta <fons@spotify.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>>> +             case EIR_MANUFACTURER_DATA:
>>> +                     if (data_len < 2 || data_len > 2 + sizeof(eir->msd->data))
>>> +                             break;
>>> +                     eir->msd = g_malloc(sizeof(*eir->msd));
>>> +                     eir->msd->company = get_le16(data);
>>> +                     eir->msd->data_len = data_len - 2;
>>> +                     memcpy(&eir->msd->data, data + 2, eir->msd->data_len);
>>> +                     break;
>>
>> Wouldn't this lead to a memory leaks if a device (violating the spec. but
>> still) had two or more manufacturer data entries in it's AD/EIR data?
>> Taking example from how remote name entries are handled you should
>> probably g_free(eir->msd) before allocating a new one.
>
> Very good point. So, should I support multiple MSD fields or just the
> first (last) one for now?
>
> In all honesty, just like Johan, I didn't even know it was legal to
> provide multiple ones.

The v4 bundle I just sent supports multiple MSD fields in the same EIR
data block.

-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
