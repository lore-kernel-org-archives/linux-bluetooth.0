Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120426145842.GA8697@x220.P-661HNU-F1>
References: <1335451079-11868-1-git-send-email-luiz.dentz@gmail.com>
	<20120426145842.GA8697@x220.P-661HNU-F1>
Date: Thu, 26 Apr 2012 18:01:29 +0300
Message-ID: <CABBYNZLTu-XM5Ns+gNYSWgW5Gyy_2-FWDgTVc7_+farTJXdzeA@mail.gmail.com>
Subject: Re: [PATCH obexd 1/2] client: Fix not propagating GError in session
 API functions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Apr 26, 2012 at 5:58 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Thu, Apr 26, 2012, Luiz Augusto von Dentz wrote:
>> +gboolean obc_session_put(struct obc_session *session, const char *contents,
>> +                             size_t size, const char *name, GError **err)
>>  {
>>       struct obc_transfer *transfer;
>>       const char *agent;
>> @@ -1052,11 +1057,11 @@ int obc_session_put(struct obc_session *session, const char *contents,
>>       agent = obc_agent_get_name(session->agent);
>>
>>       transfer = obc_transfer_put(session->conn, agent, NULL, name, NULL,
>> -                                                     contents, size, NULL);
>> +                                             contents, size, NULL, err);
>>       if (transfer == NULL)
>>               return -EIO;
>
> This doesn't seem right. You're changing the function to return gboolean
> instead of int but yet it returns -EIO upon error?

It is obviously wrong, not sure how I missed it and the compiler
didn't complain.


-- 
Luiz Augusto von Dentz
