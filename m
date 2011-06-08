Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1307555040.2669.192.camel@novo.hadess.net>
References: <BANLkTi=X16G8JreU68yFZeoqTbLfy5EyNg@mail.gmail.com>
	<1307440992-11087-1-git-send-email-hadess@hadess.net>
	<BANLkTind9qu33viRE+eSB6b7SiGhr_DTLQ@mail.gmail.com>
	<1307555040.2669.192.camel@novo.hadess.net>
Date: Wed, 8 Jun 2011 15:30:27 -0400
Message-ID: <BANLkTikqiD93ijS8rbpEijtuVH_L8dRTmA@mail.gmail.com>
Subject: Re: [PATCH] adaptername: Move adapter naming into a plugin
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Wed, Jun 8, 2011 at 1:43 PM, Bastien Nocera <hadess@hadess.net> wrote:
> <snip>
>> > -       if (read_local_name(&adapter->bdaddr, adapter->name) < 0)
>> > -               expand_name(adapter->name, MAX_NAME_LENGTH, main_opts.name,
>> > -                                                       adapter->dev_id);
>> > -
>> > -       if (main_opts.attrib_server)
>> > -               attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
>> > -                       (const uint8_t *) adapter->name, strlen(adapter->name));
>>
>> I can't find where you moved the attrib_gap_set() call to. This is
>> necessary for GATT attribute server.
>
> Check the code instead of the patch, it's already done in
> adapter_update_local_name().

In this case, it is better if you put this cleanup/refactor in a
separate patch. IMHO, you are doing two things on the same patch:

1) moving things to a plugin and removing duplicated code.
2) adding support for /etc/machine-info

These could be split in two patches. This facilitates tracking
regressions (if any) later by bisect.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
