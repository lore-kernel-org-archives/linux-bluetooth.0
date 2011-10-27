Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MbA82gzEmnLh8rz=4C27z8kDO6__T_2rFtUCqhMhbmRg@mail.gmail.com>
References: <1319712176-709-1-git-send-email-dmitriy.paliy@nokia.com>
	<CAJdJm_MbA82gzEmnLh8rz=4C27z8kDO6__T_2rFtUCqhMhbmRg@mail.gmail.com>
Date: Thu, 27 Oct 2011 16:33:37 +0300
Message-ID: <CAHMBquV8psW8-yKr71V1pS4aXdAE8S11SL16Vgd3TFzYcKZ4NQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix incorrect use of atoi in maemo6
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> There are lots of atoi() calls in other parts of BlueZ. Are they safe?

Yes

> What is exactly unsafe in using atoi()?

The string should be null-terminated, which is not in this case, since
it is just a char. It was my mistake.

Br,
Dmitriy
