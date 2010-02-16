Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix bug on ftp plugin when mimetype exists but is
 unknown
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c101002160637k59f9cb0fx963d3b489ee37df3@mail.gmail.com>
References: <2d5a2c101002160637k59f9cb0fx963d3b489ee37df3@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Feb 2010 07:33:36 -0800
Message-ID: <1266334416.8849.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> The code was returning FALSE (0) when it should return a posix error thus
> causing a unkown mimetype to not be handle by mimetype drivers as it
> should.

patch has been applied. Thanks.

Regards

Marcel


