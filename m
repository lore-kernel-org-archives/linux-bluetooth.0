Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100329073957.GA20677@jh-x301>
References: <1269894774-3193-1-git-send-email-forrest.zhao@intel.com>
	 <20100329073957.GA20677@jh-x301>
Date: Mon, 29 Mar 2010 15:58:02 +0800
Message-ID: <ac8af0be1003290058w3dfa8784h30db54c08f56a38e@mail.gmail.com>
Subject: Re: [PATCH] Check modem_obj_path is not NULL
From: Zhao Forrest <forrest.zhao@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>,
	linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> @@ -311,6 +315,10 @@ void telephony_transmit_dtmf_req(void *telephony_device, char tone)
>>
>>       debug("telephony-ofono: transmit dtmf: %c", tone);
>>
>> +     if (!modem_obj_path)
>> +             telephony_transmit_dtmf_rsp(telephony_device,
>> +                                     CME_ERROR_AG_FAILURE);
>> +
>>       tone_string = g_strdup_printf("%c", tone);
>>       ret = send_method_call(OFONO_BUS_NAME, modem_obj_path,
>
> This doesn't look right. You report an error but still proceed in the
> functions (which will later try to access modem_obj_path). I guess you
> should return from the functions in both of these if-clauses.
>
My bad. Will send out the updated patch ASAP.
