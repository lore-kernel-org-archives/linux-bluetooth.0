Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 20:49:32 +0100
From: Dave Higton <davehigton@dsl.pipex.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Arguments to PIN Code Request Response
Message-ID: <c441e70652.davehigton@dsl.pipex.com>
References: <7b86640552.davehigton@dsl.pipex.com> <CAMhHtTy7vStrSEZsj6Gcy_VO-JfL4tuYZ=TJWtQ4TxqMMGQpTQ@mail.gmail.com>
 <CAMhHtTytv2Q4JPE85T-zqgbrqpq+9XHRbgYtQWADeoip9yCP5A@mail.gmail.com>
In-Reply-To: <CAMhHtTytv2Q4JPE85T-zqgbrqpq+9XHRbgYtQWADeoip9yCP5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In message
<CAMhHtTytv2Q4JPE85T-zqgbrqpq+9XHRbgYtQWADeoip9yCP5A@mail.gmail.com>
          Ash K <ashoksarf@gmail.com> wrote:

> Hi Dave,
> 
> If you see specification the PIN_Code parameter for
> PIN_Code_request_reply command, it says
> 
> Value
> ----
> 0xXXXXXXXXXX
> XXXXXXXXXXX
> XXXXXXXXXXX
>  Parameter Description
> ----
> PIN code for the device that is to be connected. The Host should
> ensure that strong PIN Codes are used. PIN Codes can be up to a
> maximum of 128 bits. Note: The PIN_Code Parameter is a string
> parameter. Endianess does therefore not apply to the PIN_Code
> Parameter. The first octet of the PIN code should be transmitted first.
> Which means, even if your PIN code of 4 byte length you have to send
> 16 byte length of PIN code to controller. And controller uses initial
> bytes from the 16byte PIN code, the length of the PIN code is defined
> by length parameter.
> What you are looking at is correct, after 4 bytes of PIN code, you
> have some junk/host selected data which is of no interest to
> controller.

Many thanks for your explanation, Ash.

Dave
