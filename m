Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100810130643h81e09f0qc3c9cd57602867e7@mail.gmail.com>
Date: Mon, 13 Oct 2008 10:43:09 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Johan Hedberg" <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Fix possible crash on startup
Cc: "BlueZ development" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <FA1352D8-03D2-4979-99A4-5EFE5EB8872E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1223766202.31961.868.camel@cookie.hadess.net>
	 <FA1352D8-03D2-4979-99A4-5EFE5EB8872E@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I guess we can make all driver to do the discover on Connect if the
record is not available, similar to what is done in audio.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
