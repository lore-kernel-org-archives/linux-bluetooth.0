Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1311200621-2073-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1311200621-2073-1-git-send-email-anderson.lizardo@openbossa.org>
Date: Thu, 21 Jul 2011 14:06:45 -0300
Message-ID: <CAJdJm_NNXc06JFnaxFcf9xYr4gHV6+Mhr06Tz7yCNTbZycGndQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix "make distcheck" when libbluetooth is not installed
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 20, 2011 at 7:23 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Recently, the audio plugin began to include <bluetooth/sdp.h>. This only
> works after the symbolic links in lib/bluetooth/ have been created (or
> the BlueZ headers are installed on /usr/include). The BUILT_SOURCES
> automake variable can be used to force generating these symlinks prior
> to other build targets.

A similar patch was sent by Tom Rini (see
http://article.gmane.org/gmane.linux.bluez.kernel/14625), so feel free
to ignore this one.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
