Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150524135841.GA10688@t440s>
References: <1432473311-16657-1-git-send-email-luiz.dentz@gmail.com>
	<20150524135841.GA10688@t440s>
Date: Sun, 24 May 2015 18:12:28 +0300
Message-ID: <CABBYNZKSFFF+4Tk-Di1kwXDONQES5SEWS+bHk+-C1xo69nQGYg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Improbe decoding of ATT Read by Group Type Respose
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sun, May 24, 2015 at 4:58 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Sun, May 24, 2015, Luiz Augusto von Dentz wrote:
>> +static void print_group_list(const char *label, uint8_t length,
>> +                                     const void *data, uint16_t size)
>> +{
>> +     uint8_t count;
>> +
>> +     if (length == 0)
>> +             return;
>> +
>> +     count = size / length;
>> +
>> +     print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
>> +
>> +     while (size >= length) {
>> +             print_handle_range("Handle range", data);
>> +             print_uuid("UUID", data + 4, length - 4);
>> +
>> +             data += length;
>> +             size -= length;
>> +     }
>> +
>> +     packet_hexdump(data, size);
>> +}
>
> Looks good, but to avoid btmon crashes (e.g. when analyzing codenomicon
> logs) might be good to add check for 'length >= 6' and jump to
> packet_hexdump if you get something smaller than that.

print_uuid already does that and we have a check for minimal size of 4
for att_read_group_type_rsp, what I think we really want to check
field by field like is done in avctp.c for example, so we get exactly
where the pdu is breaking, but to get to that we will have to fix much
more than print_group_list


-- 
Luiz Augusto von Dentz
