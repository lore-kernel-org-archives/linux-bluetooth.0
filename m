Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMhHtTy7vStrSEZsj6Gcy_VO-JfL4tuYZ=TJWtQ4TxqMMGQpTQ@mail.gmail.com>
References: <7b86640552.davehigton@dsl.pipex.com> <CAMhHtTy7vStrSEZsj6Gcy_VO-JfL4tuYZ=TJWtQ4TxqMMGQpTQ@mail.gmail.com>
From: Ash K <ashoksarf@gmail.com>
Date: Mon, 22 Aug 2011 11:56:56 -0500
Message-ID: <CAMhHtTytv2Q4JPE85T-zqgbrqpq+9XHRbgYtQWADeoip9yCP5A@mail.gmail.com>
Subject: Re: Arguments to PIN Code Request Response
To: davehigton@dsl.pipex.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

If you see specification the PIN_Code parameter for
PIN_Code_request_reply command, it says

Value
----
0xXXXXXXXXXX
XXXXXXXXXXX
XXXXXXXXXXX
 Parameter Description
----
PIN code for the device that is to be connected. The Host should
ensure that strong PIN Codes are used. PIN Codes can be up to a
maximum of 128 bits. Note: The PIN_Code Parameter is a string
parameter. Endianess does therefore not apply to the PIN_Code
Parameter. The first octet of the PIN code should be transmitted first.
Which means, even if your PIN code of 4 byte length you have to send
16 byte length of PIN code to controller. And controller uses initial
bytes from the 16byte PIN code, the length of the PIN code is defined
by length parameter.
What you are looking at is correct, after 4 bytes of PIN code, you
have some junk/host selected data which is of no interest to
controller.

On Fri, Aug 19, 2011 at 4:25 PM, Dave Higton <davehigton@dsl.pipex.com> wrote:
> According to the Core Spec versions 4.0, 3.0, 2.1 and 2.0, the
> arguments to PIN Code Request Reply are BD_ADDR, PIN length, and
> PIN code.  However, this doesn't work with the devices I've tried
> (an Android phone and a mini keyboard); there are several more
> bytes of argument in a capture that I have.  If I only send the
> args as per the spec, I get an args not understood error; if I
> add these other arg bytes, copied from the capture, the PIN code
> is accepted and the pairing process continues.
>
> Are these extra arguments documented in one of the earlier core
> specifications, now deprecated?
>
> The bytes I have are:
>
> 0D 04 17 3F 1B AC 26 2C DC 04 30 30 30 30 17 00 0C 11 0A 11 0B 11 16 11 02 0A
>
> Unless I've badly misunderstood something, the PIN code length
> above is 4, and the PIN code is ASCII "0000".  I don't expect to
> see any bytes following "30 30 30 30".
>
> Dave
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
Ash
