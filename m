Return-Path: <cyrus@holtmann.org>
Message-ID: <476615CA.8020809@am.sony.com>
Date: Sun, 16 Dec 2007 22:23:06 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>, maxk@qualcomm.com,
        bluez-devel@lists.sf.net, dwmw2@infradead.org
Subject: Re: [Bluez-devel] [RFC] PS3 Bluetooth quirk for HCI_FLT_CLEAR_ALL
References: <463F7386.6050900@am.sony.com>	 <1178608551.8628.52.camel@aeonflux.holtmann.net>	 <1178622391.2824.34.camel@pmac.infradead.org>	 <1178630359.8628.63.camel@aeonflux.holtmann.net>	 <1178639244.2824.40.camel@pmac.infradead.org>	 <1178642601.8628.67.camel@aeonflux.holtmann.net>	 <4640FF63.8070403@am.sony.com>  <4641331E.1070408@am.sony.com>	 <1178694136.8628.82.camel@aeonflux.holtmann.net>	 <47646F04.8080301@am.sony.com> <1197768294.8050.8.camel@aeonflux>
In-Reply-To: <1197768294.8050.8.camel@aeonflux>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

On 12/15/2007 05:24 PM, Marcel Holtmann wrote:
> Hi Geoff,
> 
>> OK, so users are screaming for bluetooth support.  Can we get this
>> resolved?
>> 
>> Here is the patch again.
>> 
>> -Geoff
>> 
>> ----------------------------------------------------------------------
>> Subject: PS3 Bluetooth quirk for HCI_FLT_CLEAR_ALL
>> 
>> It seems the PS3 built-in bluetooth host controler doesn't support the
>> HCI_FLT_CLEAR_ALL command properly.  Add a check to conditionally use
>> the HCI_FLT_CONN_SETUP command to clear the event filter on PS3.
> 
> actually can you just test with a 2.6.23 or later kernel. I fixed the
> OCF_SET_EVENT_FLT since it was broken since the beginning. In case you
> give HCI_FTL_CLEAR_ALL you are not allowed to give any additional
> parameters. Otherwise the command fails. So with this command now
> succeeding, it might be enough to get Bluetooth working.

Hi Marcel,

I got the following back from our Kimoto-san, so it seems to work
properly with your update:

  I tried Bluetooth on linux 2.6.24-rc4.
  BT HID also works after boot without patch.
  I checked mouse and keyboard of Microsoft and they work well without the patch.

I'll do some more testing this coming week also.

Thanks.

-Geoff
