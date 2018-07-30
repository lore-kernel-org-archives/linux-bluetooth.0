Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <5ed6bc126555a1cc5acd3350bfc29f9a2623d841.camel@hadess.net>
Subject: Re: [PATCH v3 6/6] client: Commit changes to scan filter if active
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Mon, 30 Jul 2018 13:22:37 +0200
In-Reply-To: <20180730111427.29947-6-luiz.dentz@gmail.com>
References: <20180730111427.29947-1-luiz.dentz@gmail.com>
         <20180730111427.29947-6-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2018-07-30 at 14:14 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This detects if the command scan has been triggered and if so commit
> changes to filter immediatelly so they take effect in the current
                    ^^^^^^^^^^^^ immediately

> session.

Looks good otherwise.
