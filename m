Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308209699-3819-1-git-send-email-luiz.dentz@gmail.com>
References: <1308209699-3819-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 16 Jun 2011 09:42:38 +0200
Message-ID: <BANLkTimnTxCMZ=iNFfCUyjVi3eD5rcK-JQ@mail.gmail.com>
Subject: Re: [PATCH obexd] Fix build when pcsuite plugin is enabled
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jun 16, 2011 at 9:34 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Commit 4ae4f7c4949c6e53cd4c874c9cc533038cd03fb2 breakes the pcsuite
> plugin by changing the .read API.

Ouch! Somehow I've missed that one.

-- 
Slawomir Bochenski
