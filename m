Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958288;
	b=m3wviwfb+Ibf5L5faezATnvSvWuQxh3cf/yi8qP5cNfDVzL+56P6UyfrSN+E0b8524Hc
	 FsIJuYq0T30pa0q+ck4aa9m5cymAZVIhUkTr3J8njowWoc+w40TJpuEiKGE2rfRon8IZg
	 4hfsWMbJHlf1CWbHDG05wHbVfvp4oJ3xZgy55aIO+OtKfmjEz+If9jxo9hFFS8lN1yEcj
	 M67MykDGxMOTgxRWF4WXVIM8/EkNKNWpcXIwsdGvDIMPPwE6xfKVwu62JqMsE5aAb/yFN
	 3QoBL9bQVAHDM3RrQO8kUC1oxeA6nzyMTA2iAnTyxMaKd9UdTZ8xcJrmLwnRpOqQvqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958288;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ps0xYlSYCmwUWraNNN2Iemin8yq/Sy7PvPoXOFKbDHg=;
	b=d4WAw4yozxmEyq9g7o7kDpxcnLgghwW+oRfBPiYTy7xfXNf4D3UXW9P6AYSYiDkWwtaf
	 wsdNPYZ62xIMd6fxKPCH51ala38FhD5GeWxYsfeNG6LuiyLxMj1U6PKS0WI3uYIza1IuV
	 6FU1AQMSNo9paEeouYozbzOWc3gKdO2HfYykZpMMt/L5RIiMqiJtkubl6+QGDvk5Bn3sD
	 3cFJIB88ZmECixwrJGg4tB8r/z6TewLfWCZD6veCotpH5Sv1ZbQ/rC4LloBzQ8O+57jrF
	 s5yLWNFrgbGhNBCWZv/jYi5tcVQleVSjltRQlFUjEwF7412AYIGSdW7JIs9h13diyMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LTlnpsf/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 43AAD606A92B;
	Fri,  6 Nov 2026 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTlnpsf/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EF75D1F008A4;
	Fri,  6 Nov 2026 09:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793958287;
	bh=Ps0xYlSYCmwUWraNNN2Iemin8yq/Sy7PvPoXOFKbDHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LTlnpsf/fuUoHW4ZvhRz5tn+DZafR2Vn3mtEgHXN99FHXr9KjQGxWFD+9IuGO34EQ
	 VnR250fIMWwlHkykSsInVEHo4OQIvd+u054OXS5slL1LbfiYqHvXNCpD4ncInd1BmA
	 wD8UJuuT8I+l7gUKyXBO8hS7Jtn/p8w+Lh17h+RSo0QU+B0UrNsW5Uhm4QvZgSG9Gp
	 B/SGN8notslRhlyF8wCjzW7zMtLw8LywltQWyBQrqd7l4H6yRbESwfWg/twsxjo3fb
	 NNmJ57vpimaqxiJa9v4b7tIPbLV/XTp0+wZWPQYh7NglwH0foITHulzCGsB6tbRwR8
	 C6Dr6aWjX9Pxg==
Date: Fri, 6 Nov 2026 10:44:43 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Hex Lindqvist <hex@freenixos.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: qca: Disable SoC debug logging for WCN3990
Message-ID: <ite22xqbml5wairruy4ehopxpvk4to6qsksbfgjw3qjdm6y5q4@dtoenm5nknti>
References: <20261105201952.1556185-1-hex@freenixos.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105201952.1556185-1-hex@freenixos.com>

On Thu, Nov 05, 2026 at 12:19:52PM -0800, Hex Lindqvist wrote:
> Unless the host turns it off, the WCN3990 firmware sends debug logs to
> the host as ACL packets on handle 0x2EDC. hci_qca passes them on as
> diagnostic packets, which the core copies to the monitor socket and then
> frees. On a OnePlus 6T (SoC version 0x40010214, ROM version 0x0201) that
> is a packet of about 490 bytes every seven seconds on average, for as
> long as the controller is up.
> 
> The driver already turns this logging off after the firmware download
> for WCN3950 and WCN3991. Do the same for WCN3990.
> 
> Tested on a OnePlus 6T. With the crbtfw21.tlv rampatch from the OnePlus
> firmware, no diagnostic packets arrive any more. The controller also
> accepts the command with the crbtfw21.tlv from linux-firmware.
> 
> An AI assistant helped find and test this change and drafted this
> message.
> 
> Signed-off-by: Hex Lindqvist <hex@freenixos.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
