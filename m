Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110404220002.GF2230@joana>
References: <20110402111941.GB19357@p183.telecom.by>
	<20110404220002.GF2230@joana>
Date: Tue, 5 Apr 2011 15:33:47 +0300
Message-ID: <BANLkTimwBDydVTS2Crcbgiy7sKK+T49pHw@mail.gmail.com>
Subject: Re: [PATCH] kstrtox: convert net/bluetooth/
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Apr 5, 2011 at 1:00 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:

>> @@ -299,15 +300,13 @@ static ssize_t show_sniff_max_interval(struct device *dev, struct device_attribu
>>  static ssize_t store_sniff_max_interval(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
>>  {
>>       struct hci_dev *hdev = dev_get_drvdata(dev);
>> -     unsigned long val;
>> -
>> -     if (strict_strtoul(buf, 0, &val) < 0)
>> -             return -EINVAL;
>> -
>> -     if (val < 0x0002 || val > 0xFFFE || val % 2)
>> -             return -EINVAL;
>> +     u16 val;
>> +     int rv;
>>
>> -     if (val < hdev->sniff_min_interval)
>> +     rv = kstrtou16(buf, 0, &val);
>> +     if (rv < 0)
>> +             return rv;
>> +     if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
>>               return -EINVAL;
>
> Why are you changing other things besides the string conversions?

Because this is not mindless s/foo/bar/g conversion.

> The checks for val should stay the same.

No, they should not. kstrtou16() takes care of [0x0000, 0xFFFF] interval,
then you check for even values, then you have only 0 to ban.

WIth previous checks, say, "val > 0xFFFE" is not necessary,
kstrtou16 + "val % 2" do it.
