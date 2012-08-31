Return-Path: <cyrus@holtmann.org>
Message-ID: <50406678.5040002@linux.intel.com>
Date: Fri, 31 Aug 2012 09:23:36 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] client: Add parameters to get message in map module
References: <1346233190-6238-1-git-send-email-frederic.danis@linux.intel.com> <CABBYNZKgTHcPDGOj4Qi+6=XDqFK6g9c-zZ-tANKCjLQqhKKjQw@mail.gmail.com>
In-Reply-To: <CABBYNZKgTHcPDGOj4Qi+6=XDqFK6g9c-zZ-tANKCjLQqhKKjQw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

On 30/08/2012 17:21, Luiz Augusto von Dentz wrote:
>> +       apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_ATTACHMENT, 0);
>> +       apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_CHARSET, 1);
>> +       len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
>> +
>> +       obc_transfer_set_params(transfer, buf, len);
>> +
>> +       g_obex_apparam_free(apparam);
>> +
>>          if (!obc_session_queue(msg->data->session, transfer, NULL, NULL, &err))
>>                  goto fail;
>>
>> --
>> 1.7.9.5
>
> I have a pending patchset to address this, basically adding filters
> parameters so the application can enable what this parameters should
> be. Btw, Im confused why are you setting attachment as type uint8, the
> spec says it should assume "On" or "Off", which normally means it is
> of string type.
>

I sent this as those parameters are needed to be able to retrieve 
message on Samsung GT-I9300.
Forgot it as you have more complete patchset.

Attachment parameter is defined as a byte in chapter 6.3.1 of the MAP 
spec (page 65, bitmask with 0="OFF" and 1="ON").


-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

