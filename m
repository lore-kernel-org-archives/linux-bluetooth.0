Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100811250634vd53daafvce6791992a3c621@mail.gmail.com>
Date: Tue, 25 Nov 2008 11:34:35 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Johan Hedberg" <johan.hedberg@gmail.com>
Subject: Re: HBH-PV270 headset get locked
Cc: "BlueZ development" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <C2133416-B233-4FFF-B29B-0BCF3B3402E1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <492B7A98.90603@gmail.com> <492BB3F2.3050005@gmail.com>
	 <C2133416-B233-4FFF-B29B-0BCF3B3402E1@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

yep, client->dev = NULL seems to be a bug, although by looking the log
 it seems there is another problem, the sco connection doesn't succeed
but it still attempt to send the file descriptor. The logic on a2dp is
a little different, since it doesn't start the stream on
BT_SETCONFIGURATION_REQ and unlock the sep in any possible error.

Btw, I couldn't reproduce the problem here by using aplay, arecord or
even both together.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
