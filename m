Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1398143280-21017-1-git-send-email-martin.kampas@tieto.com>
References: <1398143280-21017-1-git-send-email-martin.kampas@tieto.com>
Date: Wed, 23 Apr 2014 10:24:17 +0300
Message-ID: <CABBYNZL763g4AptiqcS-M4LvwD1BwMQnZg=HLHiJGYCG9qznFg@mail.gmail.com>
Subject: Re: [PATCH] obex-client-tool: Set the length header
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Martin Kampas <martin.kampas@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Tue, Apr 22, 2014 at 8:08 AM, Martin Kampas <martin.kampas@tieto.com> wrote:
> At least 'put' to other device with obexd v0.48 does not work without
> this.

The patch itself is fine but there got to be something wrong with
obexd if it cannot accept a PUT without length, maybe it is the agent
that is rejecting it?


-- 
Luiz Augusto von Dentz
