Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121121185130.GB3074@x220.P-661HNU-F1>
References: <1353506992-3371-1-git-send-email-jefferson.delfes@openbossa.org> <20121121185130.GB3074@x220.P-661HNU-F1>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
Date: Wed, 21 Nov 2012 15:04:07 -0400
Message-ID: <CA+_d9qeu4KpJB2hNz8Tk+ge6DX_wH+rCfz8KnhgPoP1h_vsdYg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hciconfig: Add an option to set which advertise
 type will be on
To: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan.

I did compare with "noleadv" because if you have some param in
command.opt, main function drops one argument (command name) and it
will pass only the parameter of the command. So or it will be empty,
or it will have the argument for leadv.

I can split this function. Probably it will be more intuitive.

Thanks.
