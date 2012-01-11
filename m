Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120103120351.GA12920@aemeltch-MOBL1>
References: <20120103015131.GA1239@samus>
	<20120103120351.GA12920@aemeltch-MOBL1>
Date: Wed, 11 Jan 2012 17:54:44 -0200
Message-ID: <CAA37ikZLk8JXP=B++XfWEvU6iosUBuWM45+Hn1fXRXYzVQREwA@mail.gmail.com>
Subject: Re: [BUG] Sleeping inside a RCU reader
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Is this bug still present? I haven't seen any more updates on this thread.

Thanks,
Regards,

-- Ulisses

On Tue, Jan 3, 2012 at 10:03 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Vinicius,
>
> On Mon, Jan 02, 2012 at 10:51:31PM -0300, Vinicius Costa Gomes wrote:
>> Hi,
>>
>> I found this bug (trace attached) and I don't think I will be able to
>> start working on it in the next 11 hours, so this email is to make
>> the life of anyone who wants to work on it a little easier. (If anyone
>> wishes to work on this, please respond this email).
>>
>> I was able to reproduce it consistenly doing a "hciconfig <dev> down"
>> with an established connection. I was using LE devices, but it seems that
>> the types of the devices don't matter.
>>
>> The problem is that cancel_delayed_work_sync() called inside
>> hci_conn_del() is blocking, because of and called in the context of an RCU
>> (inside hci_conn_hash_flush()).
>
> I think that if the RCU code is not protected by rcu_read_{,un}lock then
> it is OK to sleep (and this is updater anyway).
>
> In that function "hci_conn_hash_flush" maybe it is better to use
> list_for_each_entry instead of list_for_each_entry_rcu for better
> readability?
>
> Best regards
> Andrei Emeltchenko
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
