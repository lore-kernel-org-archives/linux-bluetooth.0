Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Nov 2011 23:52:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/6] Parse final measurement indication
Message-ID: <20111114215226.GA21254@fusion.localdomain>
References: <1321272680-16286-1-git-send-email-sancane@gmail.com>
 <1321272680-16286-2-git-send-email-sancane@gmail.com>
 <1321272680-16286-3-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321272680-16286-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Mon, Nov 14, 2011, Santiago Carot-Nemesio wrote:
> +	dict_append_entry(&dict, "Exponent", DBUS_TYPE_INT16, &m->exp);
> +	dict_append_entry(&dict, "Mantissa", DBUS_TYPE_INT32, &m->mant);

Could you remind me why we have this kind of encoding in the D-Bus
interface instead of using the native DBUS_TYPE_DOUBLE? Using
DBUS_TYPE_DOUBLE seems like the obvious & clean approach from an API
standpoint so there should be good reasons for not using it.

Johan
