Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120927074101.GA9610@x220>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
	<1348594686-26221-7-git-send-email-jprvita@openbossa.org>
	<20120927074101.GA9610@x220>
Date: Thu, 27 Sep 2012 15:20:14 -0300
Message-ID: <CAKT1EBcxV5xC5a4N=C1QnUfBc_Z30G8CkHERRbQcW+NaM5oMjA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 7/9] core: Re-connect for ECONNRESET or ECONNABORTED
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Thu, Sep 27, 2012 at 4:41 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Sep 25, 2012, João Paulo Rechi Vita wrote:
>> +     /*
>> +      * Keep scanning/re-connection active if disconnection reason
>> +      * is page timeout, remote user terminated connection or local
>> +      * initiated disconnection.
>> +      */
>> +     if (err == ETIMEDOUT || err == ECONNRESET || err == ECONNABORTED)
>> +             adapter_connect_list_add(device_get_adapter(device), device);
>
> Page timeouts have always been reported through EHOSTDOWN so either the
> comment or the code is wrong here.
>
> Johan

The comment is wrong: s/page/connection

Regards,
Claudio
