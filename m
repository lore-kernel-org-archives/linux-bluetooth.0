Return-Path: <cyrus@holtmann.org>
Date: Sat, 29 Sep 2012 18:12:40 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Kevin Wilson <wkevils@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: scan fails
Message-ID: <20120929211240.GA8075@echo>
References: <CAGXs5wX2N7P5=_ZwPPUw-kUxGjhpMB2xyfWHmHOUM99XggvQ2Q@mail.gmail.com>
 <CAGXs5wVu=deRjaKwh0wLKCPy+Pqf3F9rH4pMyCCPCM_iA-yNeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXs5wVu=deRjaKwh0wLKCPy+Pqf3F9rH4pMyCCPCM_iA-yNeg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kevin,

On 22:29 Sat 29 Sep, Kevin Wilson wrote:
> Hi,
> Sorry , just forget to mention that in reset I also
> get an error:
> hciconfig hci0 reset
> Can't init device hci0: Connection timed out (110)

Can you install hcidump (IIRC in Fedora it is called bluez-hcidump) and send
the log, pass '-Xt' to it please, when doing 'hciconfig hci0 up'? 

Right now, I am thinking that our initialization procedure sends a command
that your device doesn't support, probably because we expect a newer Bluetooth
version than your device is.

> kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
