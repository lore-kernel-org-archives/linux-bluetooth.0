Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>
Date: Sat, 4 Oct 2008 00:47:10 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Stuart Pook" <kernel6org@pook.es>
Subject: Re: bluez-4.9 + 2.6.27-rc8 + SCO headset -> bluetoothd: connect: Operation not permitted
Cc: "David Sainty" <david.sainty@dtsp.co.nz>,
	"BlueZ development" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48E3B3BF.6070205@pook.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>
	 <48E3B3BF.6070205@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is a regression on bluetoothd daemon, we introduce a SCO socket
listen recently which is causing the problem, although it seem that
the driver is also cooperating with the problem.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
