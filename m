Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v2] android: Add support for Valgrind in debug variants
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1391591653-17254-2-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Wed, 5 Feb 2014 10:44:48 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <CCEBD434-F41A-4CC1-81BF-96869F1E2FDE@holtmann.org>
References: <1391591653-17254-1-git-send-email-andrzej.kaczmarek@tieto.com> <1391591653-17254-2-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> +
> +#include <cutils/properties.h>
> +
> +#define PROPERTY_NAME "persist.sys.bluetooth.valgrind"
> +
> +#define VALGRIND_BIN "/system/bin/valgrind"
> +
> +#define BLUETOOTHD_BIN "/system/bin/bluetoothd-main"
> +
> +int main(int argc, char *argv[])
> +{
> +	char value[PROPERTY_VALUE_MAX];
> +	char *prg_argv[4];
> +	char *prg_envp[3];
> +
> +	if (property_get(PROPERTY_NAME, value, "") <= 0)
> +		goto run_bluetoothd;
> +
> +	if (strcasecmp(value, "true") && atoi(value) == 0)
> +		goto run_bluetoothd;
> +
> +	prg_argv[0] = VALGRIND_BIN;
> +	prg_argv[1] = "--leak-check=full";
> +	prg_argv[2] = BLUETOOTHD_BIN;
> +	prg_argv[3] = NULL;
> +
> +	prg_envp[0] = "G_SLICE=always-malloc";
> +	prg_envp[1] = "G_DEBUG=gc-friendly";
> +	prg_envp[2] = NULL;
> +
> +	execve(prg_argv[0], prg_argv, prg_envp);
> +
> +run_bluetoothd:
> +	prg_argv[0] = BLUETOOTHD_BIN;
> +	prg_argv[1] = NULL;
> +
> +	prg_envp[0] = NULL;
> +
> +	execve(prg_argv[0], prg_argv, prg_envp);
> +
> +	return 0;
> +}

the usage of a goto label here is completely wrong. Create two functions. One to execve bluetoothd without valgrind and one to execve bluetoothd with valgrind.

Regards

Marcel

