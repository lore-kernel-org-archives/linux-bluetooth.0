Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <52FEDDCD-B2BB-4D85-A510-2E080C85D483@hella-gutmann.com>
References: <52FEDDCD-B2BB-4D85-A510-2E080C85D483@hella-gutmann.com>
From: Josh Van Tol <josh@afdengineering.com>
Date: Thu, 6 Jul 2017 08:08:16 -0500
Message-ID: <CABdDuZ2M+t+eOsF0tpH7Eaqk4c7fTx78C5w714knA08EUAGaPA@mail.gmail.com>
Subject: Re: Bluetooth Certification Testing L2CAP eRTM Test Failing
To: Heiko Abraham <heiko.abraham@hella-gutmann.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I don't have a specific answer to this question, but I do find myself
in a similar situation of trying to figure out which functions of
BlueZ 5 might or might not work when used with an older kernel,
3.12.70 in my case. I haven't found a specific source of information
on this topic, only scattered references to the fact that some BlueZ 5
features only work with newer (4.1+?) kernels. Is there a
comprehensive source for this info?

Regards,
Josh van Tol

On Wed, Jul 5, 2017 at 11:11 AM Heiko Abraham
<heiko.abraham@hella-gutmann.com> wrote:
>
> Hi,
>
> I am trying to qualify our Bluez 5.45 stack as a host subsystem with the
> Bluetooth Sig. Right now I am running into an issue with eRTM. It looks
> like eRTM is not well supported.
>
> I use kernel 3.12.74 and BlueZ 5.45 on an ARM platform.
>
> Can anyone tell me, if eRTM works well with kernel 3.12.x?
>
>
> Best Regards
> Heiko Abraham
>
> ________________________________
>
> --
> Hella Gutmann Solutions GmbH * Unternehmensform: Gesellschaft mit beschraenkter Haftung *
> Firmensitz: 79241 Ihringen * Eingetragen im Handelsregister: AG Freiburg i.Br., HRB 290194 * Geschaeftsfuehrer: Andreas Habeck * USt-IdNr.: DE142208666
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
