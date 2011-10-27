Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319712176-709-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1319712176-709-1-git-send-email-dmitriy.paliy@nokia.com>
Date: Thu, 27 Oct 2011 09:22:45 -0400
Message-ID: <CAJdJm_MbA82gzEmnLh8rz=4C27z8kDO6__T_2rFtUCqhMhbmRg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix incorrect use of atoi in maemo6
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Oct 27, 2011 at 6:42 AM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> Use of atoi is incorrect and unsafe in maemo6 telephony and replaced
> by g_ascii_digit_value.

There are lots of atoi() calls in other parts of BlueZ. Are they safe?
What is exactly unsafe in using atoi()?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
