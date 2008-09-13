Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100809121915o351f9dceqa3e72cdfeeddaa1a@mail.gmail.com>
Date: Fri, 12 Sep 2008 23:15:52 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: Input pairing broken again
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1221265310.10249.10.camel@macbook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1221265310.10249.10.camel@macbook.infradead.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

Could you please provide us the output of bluetoothd -dn and
dbus-monitor --system sender='org.bluez'?

If that is taking too long Im afraid we cannot search for drivers uuis
thus searching for l2cap uuid seems to be the only alternative.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
