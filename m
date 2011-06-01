Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikAfy-=MRTb_SGa8d2td5oq73xGYg@mail.gmail.com>
References: <BANLkTikAfy-=MRTb_SGa8d2td5oq73xGYg@mail.gmail.com>
Date: Wed, 1 Jun 2011 11:32:33 -0400
Message-ID: <BANLkTikmin21C5ZRN7PsZcfo1kzmGYvbFQ@mail.gmail.com>
Subject: Re: Binary PIN Support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, "Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Wed, Jun 1, 2011 at 10:47 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Any comments or other ideas?

What about a "BinaryPIN" adapter property (default: False) that when
set to True treats the PIN data as binary stream and not as string? It
shall be False by default so to not break backwards compatibility.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
