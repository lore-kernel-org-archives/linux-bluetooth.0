Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <41942.172.16.2.1.1375965758.squirrel@gesmail.globaledgesoft.com>
References: <41942.172.16.2.1.1375965758.squirrel@gesmail.globaledgesoft.com>
Date: Thu, 8 Aug 2013 09:00:14 -0400
Message-ID: <CAJdJm_Mv6jvaVsAHAdc3wJ1ydGdtfDTe3+diDP+WcR0MpZHyog@mail.gmail.com>
Subject: Re: Gatt Thermometer Server Support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: ajay.kv@globaledgesoft.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AJay,

On Thu, Aug 8, 2013 at 8:42 AM,  <ajay.kv@globaledgesoft.com> wrote:
>     Here we could not find the UUID for Thermometer(1809) and heartrate ,
> which we are interested to debug more.
>
> Query:
> How to set the dummy temperature or heartrate values in the server and
> to get them in the Client.?

Unfortunately, the Thermometer  role (i.e. "Server") is not supported
in BlueZ. You can only connect and read measurements from other
thermometers. Same applies to Heart Rate Profile.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
