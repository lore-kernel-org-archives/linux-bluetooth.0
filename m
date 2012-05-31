Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 10:43:25 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/5] Bluetooth: Simplify a the connection type handling
Message-ID: <20120531074323.GC17461@aemeltch-MOBL1>
References: <1338423620-32578-1-git-send-email-vinicius.gomes@openbossa.org>
 <1338423620-32578-4-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338423620-32578-4-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, May 30, 2012 at 09:20:19PM -0300, Vinicius Costa Gomes wrote:
>  		return add_le_conn(hdev, dst, dst_type, sec_level, auth_type);
>  		return add_acl_conn(hdev, dst, sec_level, auth_type);
> +		return add_sco_conn(hdev, dst, sec_level, auth_type);

Those new functions are only ones missing hci prefix in that file? Maybe
names like hci_add_acl or hci_connect_acl would be better?

Best regards 
Andrei Emeltchenko 

