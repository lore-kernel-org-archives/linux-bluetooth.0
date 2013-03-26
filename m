Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1364314434-9796-2-git-send-email-mikel.astiz.oss@gmail.com>
References: <1364314434-9796-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1364314434-9796-2-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 26 Mar 2013 12:27:11 -0400
Message-ID: <CAJdJm_OD8CXrtpmQf3_-Rj7qLqC2R3jw_SEZdKAXuSJfFJ56LQ@mail.gmail.com>
Subject: Re: [RFC v1 01/11] core: Add btd_service to represent device services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Mar 26, 2013 at 12:13 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> +static const char *state2str(btd_service_state_t state)
> +{
> +       switch(state) {

There is a missing space above, should be "switch (state)".

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
