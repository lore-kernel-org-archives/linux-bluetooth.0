Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <44EE5C37ADC36343B0625A05DD408C4850690BAE6D@CHEXMB-01.global.atheros.com>
References: <4A88B9F0.7040407@linpus.com> <4A8A0118.8070000@linpus.com>
	 <2a9506370908172041h785648c9nc9e830191d172944@mail.gmail.com>
	 <44EE5C37ADC36343B0625A05DD408C4850690BAE6D@CHEXMB-01.global.atheros.com>
Date: Wed, 19 Aug 2009 00:19:38 -0300
Message-ID: <6b53b1990908182019s3d03f0dam9e1012175f866b03@mail.gmail.com>
Subject: Re: L2CAP/RFCOMM feature implementation status
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: Jothikumar Mothilal <Jothikumar.Mothilal@atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jothikumar,

On Tue, Aug 18, 2009 at 9:15 AM, Jothikumar
Mothilal<Jothikumar.Mothilal@atheros.com> wrote:
> Hi,
> We are running the L2CAP, RFCOMM test cases using BITE tester.
>
> From below link I understand BlueZ is not supporting
>
> (http://www.bluez.org/something-to-bite/)
> *       L2CAP flow control and retransmission (deprecated by a Core Addendum)

No, now are to looking to the new modes specified by the Core
Specification Addendum: The Enhanced Retransmission mode and the
Streaming mode. I'm working on the implementation of both modes,
helped by Marcel. Enhanced Retransmission and Streaming mode will be
available soon.

> *       RFCOMM support for sending RLS (receiving works)
> Is the above statement is still valid or  implemented in latest BlueZ(Which version). Please clarify.
>
> Thanks,
> Jothi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Gustavo F. Padovan
http://padovan.org
