Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikQM1q1BPw-KbeAomLkxb2L9zW0hg@mail.gmail.com>
References: <BANLkTikb5hQAP-v=JbQa6j5L71Ki0kZoPA@mail.gmail.com>
	<BANLkTikQM1q1BPw-KbeAomLkxb2L9zW0hg@mail.gmail.com>
Date: Mon, 13 Jun 2011 09:19:49 -0400
Message-ID: <BANLkTiknR8WPSXj0g26WCABre9koOdJaTQ@mail.gmail.com>
Subject: Re: GAP Discovery and Connection establishment for LE
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jun 13, 2011 at 9:15 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> On Fri, Jun 10, 2011 at 5:04 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Scan interval: 2.5ms
>> Scan window: 2.5ms
>> Conn_Interval_Min: 5ms
>> Conn_Interval_Max: 160ms
>> Supervision timeout: 62.5ms (this is incorrect, it shall be larger
>> than Conn_Interval_Max)
>
> I made a mistake reading the parameters. Supervision timeout is
> actually 2560ms, which is valid.

Again, another mistake :) it is 1000ms (one second). We should really
comment those constants, to avoid having to consult the spec every
time (each parameter may have its own "scale", supervision timeout is
N x 10ms , conn_interval_* are N x 1.25ms, scan interval/window are N
x 0.625ms)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
