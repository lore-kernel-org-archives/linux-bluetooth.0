Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1395999467-29192-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395999467-29192-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1395999467-29192-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Fri, 28 Mar 2014 07:27:51 -0400
Message-ID: <CAJdJm_Mq02JqKNA7SMS+-PE0D2EOTK=Z2VnwQPeyuNAaCYUQaw@mail.gmail.com>
Subject: Re: [RFC v3] mgmt-api: Add support for Read Remote RSSI
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Mar 28, 2014 at 5:37 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> +Register Remote RSSI Change Command
> +===================================
> +
> +       Command Code:           0x0031
> +       Controller Index:       <controller id>
> +       Command Parameters:     Address (6 Octets)
> +                               Address_Type (1 Octet)
> +                               Threshold (1 Octet)
> +       Return Parameters:      Address (6 Octets)
> +                               Address_Type (1 Octet)
> +
> +       This command is used to register on Remote RSSI Change with given
> +       threshold. If threshold is exceeded then Remote RSSI Changed event
> +       is sent.
> +
> +       Threshold shall be greater than 0.
> +
> +       Threshold will be remembered during power down/up toggles.
> +
> +       This command generates a Command Complete event on success
> +       and on failure.
> +
> +       Possible errors:        Invalid Parameters
> +                               Invalid Index

What should happen if you attempt a Register again for the same address?

I wonder also how can you tune the period for the readings (at least a
debugfs entry should be provided for this). E.g. every 1s , every 10s
etc.

> +Unregister Remote RSSI Change Command
> +=====================================
> +
> +       Command Code:           0x0032
> +       Controller Index:       <controller id>
> +       Command Parameters:     Address (6 Octets)
> +                               Address_Type (1 Octet)
> +       Return Parametes:       Address (6 Octets)
> +                               Address_Type (1 Octet)
> +
> +       This command is used to unregister from Remote RSSI Change event
> +       started with Register Remote RSSI Change command.
> +
> +       This command generates Command Complete event on success
> +       and on failure.
> +
> +       Possible errors:        Rejected
> +                               Invalid Parameters
> +                               Invalid Index

In which case "Rejected" will be reported?

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
