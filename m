Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1504602205.5928.5.camel@hadess.net>
References: <20170904181212.5639-1-hadess@hadess.net> <20170904181212.5639-4-hadess@hadess.net>
 <1504602205.5928.5.camel@hadess.net>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Tue, 5 Sep 2017 11:13:59 +0200
Message-ID: <CAAEJBhJpr_shNrShELVqATj3aiPQTV+saTY=cDXetYn87PQghw@mail.gmail.com>
Subject: Re: [PATCH 4/9] plugins/sixaxis: Move device discovery to shared header
To: Bastien Nocera <hadess@hadess.net>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On 5 September 2017 at 11:03, Bastien Nocera <hadess@hadess.net> wrote:
> On Mon, 2017-09-04 at 20:12 +0200, Bastien Nocera wrote:
>> <snip>
>> +
>> +inline CablePairingType
>> +get_pairing_type(uint16_t   vid,
>> +              uint16_t   pid,
>> +              char     **name,
>> +              uint16_t  *source,
>> +              uint16_t  *version)
>
> I have a slightly updated version of that section. "static" is missing
> in front of the inline function for use with RPM build's strict linker
> settings, and I'm sure the indentation police would like to see that
> function return type and name on the same line ;)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I'm not sure why this is in header in first place ?

-- 
pozdrawiam
Szymon K. Janc
