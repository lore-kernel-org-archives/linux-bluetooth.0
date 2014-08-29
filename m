Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
Date: Fri, 29 Aug 2014 10:50:03 +0300
Message-ID: <CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com>
Subject: Re: [PATCH] gatt api V2
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gu Chaojie <chao.jie.gu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	marcel@holmann.org, Arman Uguray <armansito@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 29, 2014 at 9:59 AM, Gu Chaojie <chao.jie.gu@intel.com> wrote:
> From: Chaojie Gu <chao.jie.gu@intel.com>
>
> This patch focus on implementing the Gatt DBus API defined in gatt-api.txt discussed in mailist latestly. It implement all the DBus property and method except for array{object} of characteristics and descriptors. Through our internal test, patche work well. I would like to contribute this featrue for bluez upstream. This first patch is just an implementation, maybe not very closely suitable for design or put in the right file. It would be OK to modify to make more sense.
> Arman, Marcel, would you like to review the patch and give some suggestion for the patch? It would be great honor for me to contribute little to bluez.

Too big patch to review all at once, could you please split. Also
please keep the patch description limited to 80 columns considering
the extra spaces that git log adds.


Luiz Augusto von Dentz
