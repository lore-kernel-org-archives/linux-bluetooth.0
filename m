Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimM6B7y8ZpmqBCuSRZNjN5jFv=Wvg@mail.gmail.com>
References: <1307487014-19398-1-git-send-email-vinicius.gomes@openbossa.org>
	<BANLkTimM6B7y8ZpmqBCuSRZNjN5jFv=Wvg@mail.gmail.com>
Date: Thu, 9 Jun 2011 09:09:49 -0400
Message-ID: <BANLkTi=19esZYZLcvrNbC2Sw4fd23w54XA@mail.gmail.com>
Subject: Re: [bluetooth-next 00/13] SMP Key Exchange Support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jun 9, 2011 at 9:02 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> This patches seems to be working fine, tried with pts and some other
> stacks without problem, the only inconvenients for testing are the
> hardcoded io capabilitity, hardcoded distribution keys (it seems we
> distribute only LTK) and not being able to remove keys other than
> remove the adapter (didn't try reset).

About the "not being able to remove keys" part, there is some proposal
(original code is from Johan) to a "mgmt tool" that could be used to
remove keys. Also note that if the remote reports pairing error due to
"missing key or PIN", the bluez side will forget the keys and issue a
fresh pairing.

Not sure what you meant about "hardcoded distribution keys". IIRC I've
seen at least master and identity information distributed as well (but
Vinicius can definitely confirm or deny that).

HTH,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
