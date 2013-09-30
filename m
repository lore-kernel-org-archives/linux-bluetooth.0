Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <52498C8C.4070200@linux.intel.com>
References: <1380024798-32017-1-git-send-email-frederic.danis@linux.intel.com>
	<1380024798-32017-3-git-send-email-frederic.danis@linux.intel.com>
	<7A4917A5-AD76-48AD-8C04-11707D64CE37@holtmann.org>
	<52498C8C.4070200@linux.intel.com>
Date: Mon, 30 Sep 2013 22:26:13 +0300
Message-ID: <CAMXE1-pFYMRUEpKdjsZLov=k8tMQBYLA5QJcmCC+NqfXbBHkTA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] android: Android version of log.c
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Bluetooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary=e89a8f3bae5d2dc1a004e79ecf15
List-ID: <linux-bluetooth.vger.kernel.org>

--e89a8f3bae5d2dc1a004e79ecf15
Content-Type: text/plain; charset=ISO-8859-1

Hi,

"Frederic Danis" <frederic.danis@linux.intel.com>
>
> Hello Marcel,
>
>
> On 27/09/2013 04:01, Marcel Holtmann wrote:
>>>
>>> Add logging system to BlueZ Android daemon.
>>> >Android build will use android/log.c file while autotools build will
use
>>> >src/log.c instead.
>>
>> lets just use stdout for now. Changing this later is pretty trivial and
introducing large build alternates is a bit too complicated at this point.
>
>
> I do not understand how writing code to log to stdout can be more simple
than building and linking existing code.

I agree with Frederic here. Why do we use error, warn, DBG, etc if we print
to stdout?

This actually will significantly slow log parsing since first you pay
attention to error messages. If all messages are printed with the same
priorities then we loose this ability.

Regards,
Andrei

--e89a8f3bae5d2dc1a004e79ecf15
Content-Type: text/html; charset=ISO-8859-1

<p dir="ltr">Hi,</p>
<p dir="ltr">&quot;Frederic Danis&quot; &lt;<a href="mailto:frederic.danis@linux.intel.com">frederic.danis@linux.intel.com</a>&gt;<br>
&gt;<br>
&gt; Hello Marcel,<br>
&gt;<br>
&gt;<br>
&gt; On 27/09/2013 04:01, Marcel Holtmann wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Add logging system to BlueZ Android daemon.<br>
&gt;&gt;&gt; &gt;Android build will use android/log.c file while autotools build will use<br>
&gt;&gt;&gt; &gt;src/log.c instead.<br>
&gt;&gt;<br>
&gt;&gt; lets just use stdout for now. Changing this later is pretty trivial and introducing large build alternates is a bit too complicated at this point.<br>
&gt;<br>
&gt;<br>
&gt; I do not understand how writing code to log to stdout can be more simple than building and linking existing code.</p>
<p dir="ltr">I agree with Frederic here. Why do we use error, warn, DBG, etc if we print to stdout?</p>
<p dir="ltr">This actually will significantly slow log parsing since first you pay attention to error messages. If all messages are printed with the same priorities then we loose this ability.</p>
<p dir="ltr">Regards,<br>
Andrei <br>
</p>

--e89a8f3bae5d2dc1a004e79ecf15--
