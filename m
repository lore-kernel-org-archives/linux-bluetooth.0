Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKQ592p--QnfZ-Swx1-37B5z4kSGqCr1YzUCk+EMLXv_Q@mail.gmail.com>
References: <1318324718-19760-1-git-send-email-dmitriy.paliy@nokia.com>
	<CABBYNZKGzBROENrBs0g8RQPBR4faeugOqXr5=FyjykHu5fn3Kw@mail.gmail.com>
	<CAHMBquWOHbNp8DLcNRRHwyPF8qs3GgFFz83AbkLJdFoBfk0Wpw@mail.gmail.com>
	<CABBYNZKQ592p--QnfZ-Swx1-37B5z4kSGqCr1YzUCk+EMLXv_Q@mail.gmail.com>
Date: Tue, 11 Oct 2011 14:02:05 +0300
Message-ID: <CABBYNZ+PGnK_4UX9_imCxQLozO9xrEiL-QUB+w95gL78zuTUoQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix call status in +CLCC for maemo6 telephony
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 11, 2011 at 1:57 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Also, I guess the number of active calls must be > 1 to be on waiting, isn't it?

Please ignore this, the call won't be active so > 0 is correct.


-- 
Luiz Augusto von Dentz
