Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4974D9E1.7070003@suse.de>
References: <49696D00.9030604@gmail.com>
	 <1232292554.5095.26.camel@californication> <49739C4F.10905@gmail.com>
	 <4974D9E1.7070003@suse.de>
Date: Fri, 23 Jan 2009 19:11:12 -0300
Message-ID: <2d5a2c100901231411y10d4a5aay45e30eca619088ed@mail.gmail.com>
Subject: Re: app doesn't recieve signal DeviceDisappeared
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: tpatzig@suse.de
Cc: Ilya Rubtsov <lusyaru@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

It should've been fixed now. Note that you only got those signals
while a discovery session is active (someone called
Adapter.StartDiscovery()).

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
