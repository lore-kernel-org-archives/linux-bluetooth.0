Return-Path: <cyrus@holtmann.org>
Message-ID: <1349794286.27233.95.camel@aeonflux>
Subject: Re: [PATCH 2/9] Pass confirm name as gboolean value
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 09 Oct 2012 16:51:26 +0200
In-Reply-To: <1349784722-14578-3-git-send-email-szymon.janc@tieto.com>
References: <1349784722-14578-1-git-send-email-szymon.janc@tieto.com>
	 <1349784722-14578-3-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> confirm_name is a boolean value and can be pass as such instead of
> uint8_t.

actually long term I want to move to bool usage. So maybe this is a good
start to get this going.

Regards

Marcel


