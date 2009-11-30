Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <912bb79a0911292030m7bdbe03w744145e4d16f6a68@mail.gmail.com>
References: <912bb79a0911272152y6fb12a05p299090e97ac91a54@mail.gmail.com>
	 <4B115279.3060705@openwide.fr>
	 <912bb79a0911292030m7bdbe03w744145e4d16f6a68@mail.gmail.com>
Date: Mon, 30 Nov 2009 11:47:21 +0530
Message-ID: <912bb79a0911292217w10dbbf2bpbbd4e0326982d769@mail.gmail.com>
Subject: Right way of pairing?
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I forgot to tell that, for headset device paring, I have hard coded
the pin code  "0000" in bluetoothd.

Now  If I open RFCOM socket connection, connect with another device,
then close that RFCOM socket, Will bluetoothd remove all the pairing
information from the linkkeys file or not.

Because When I close RFCOM connection pairing information is getting
lost, I would like to know weather it's a common or am I doing
something wrong??

Your suggestion would be a great help for me..



-- 
With Regards,
Nirav Rabara
