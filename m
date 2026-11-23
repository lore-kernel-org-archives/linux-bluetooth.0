Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477593;
	b=lqvDk7KRhSNnSOxHWEPZ/PwAg4mQlsZD4uoCN1vaPY6NwIiGnB9xZA0d1cKD4dj9OeOH
	 CWJyJniim8iuFKn0sJgesGk0ToFzj5i6g9sRZ3MQ+ZXCInFwg8QA4PMkVafa61kWsw5cY
	 kVBE+XiM/Lt0inT0RjqWnElk/JQK/9uEfbA6Eh6s7NsmXhCbps0Sbsui4wEZkzk4JU3MI
	 p5Hrj/ltmbNOkJ+nr69H6pBmUm9bpt0lY69Nm84J9/G8OWpZy0IeCVN+S7AaWQDGiBcMI
	 6PqYH41ZzbnkMkjTDm7X2J4MBvfoH0fOkzK5RmFcn0oLrTgLNSQovRJR3SvSccDDn1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477593;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vP+ADNOiSpoNKhzRfreKdcuyfRb2mBj2cg+6BGIcmWA=;
	b=UYdsEqJg170mA9eG3BPQR2C9P3726lc0tnneumezikKB8TxiaH9N6hzpRXQAsne417xU
	 wS3cvPpmJv/RmQTXheLaN5AfO4lNmAD2iUFkVVEDl7WbNYraH32je0cW3HknbfmMWjV14
	 os4ntM0QhdcnU1qCXzhyGWykGMVr4KqhTdbpMRnrgTY+kspUnCRw5LhwyJZB8FYn7sbDB
	 cZCUWIEOWObh+FgGxvuAnOtR+mYj8zkzXYGLsTTz+lNos10a1frcKQnpGwPSlNedxH2RC
	 vze8AEFb03SFEpj5iwQCJ0IW+uAB0rJNZ8XNstkpUIBsUAEUfrbFIoKZMYiQuTfWDHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTCO8u41;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDFF606A321;
	Mon, 23 Nov 2026 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTCO8u41
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B20F1F000C4;
	Mon, 23 Nov 2026 23:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795477592;
	bh=vP+ADNOiSpoNKhzRfreKdcuyfRb2mBj2cg+6BGIcmWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JTCO8u41i5Bb63hP2HzKMLTu5crJT75CuGJBKjDW9CVzdAiH9b/q2NiyQXnq06ysN
	 H+JC5kMU8GuxnJ13S18qOoAnHU+W0zg3nRvfMTddR1TdBCNVZ/Qg4n0rER/VhxFdm/
	 HQf5Yhwa2mg7d6Og6Q/qFQ5aSPq7zLM59V6HaoPxRYHT+0IlngnLoDArP+WU78u6eX
	 kt7gVcGOG9jlHpyo7ic1sxFDh6uSkWfAN4eYOLfVdl7fBy6XxoxPFnAnpYBoqbWDIL
	 y14H4zJnW30ARhaWfLhc+B4cWyq62UHAQ/7OZrkMRb+dd6c/TnjmBr0M76L5mn36da
	 I/UK0uuJKoQPQ==
Date: Mon, 23 Nov 2026 15:46:31 -0800
From: Drew Fustini <fustini@kernel.org>
To: Thomas Gerner <thomas.gerner@muenchen-mail.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: dts: thead: Enable bluetooth on
 BeagleV-Ahead
Message-ID: <awTQV54SY8-p0rCx@thelio>
References: <20261020132604.90708-1-thomas.gerner@muenchen-mail.de>
 <20261020132604.90708-3-thomas.gerner@muenchen-mail.de>
 <awDZBiX1VoSkO6F3@x1>
 <a1b47af8-72bf-4f3e-9ece-e2ceeb97a682@muenchen-mail.de>
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
In-Reply-To: <a1b47af8-72bf-4f3e-9ece-e2ceeb97a682@muenchen-mail.de>

On Sat, Nov 21, 2026 at 12:09:29PM +0100, Thomas Gerner wrote:
> Am 21.11.26 um 00:34 schrieb Drew Fustini:
> > On Tue, Oct 20, 2026 at 03:26:04PM +0200, Thomas Gerner wrote:
> > > On the BeagleV-Ahead the bluetooth module of the Ampak AP6203BM is
> > > identified by the btbcm driver as BCM4362A2. The module is connected by
> > > UART4, several gpio pins and an I2S interface. The I2S is currently not
> > > used as there is currently no driver.
> > > 
> > > Signed-off-by: Thomas Gerner <thomas.gerner@muenchen-mail.de>
> > > ---
> > > Changes in v2:
> > > 	- use default pinctrl definition for bluetooth in and out pins
> > Thanks for sending v2. Sorry for the delay in review.
> > 
> > > 	
> > >   .../boot/dts/thead/th1520-beaglev-ahead.dts   | 85 +++++++++++++++++++
> > >   1 file changed, 85 insertions(+)
> > > 
> > > diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > index e16484a47653..7161a9d4c61f 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > @@ -76,6 +76,23 @@ led-5 {
> > >   		};
> > >   	};
> > > +	reg_vbat_1v8: regulator-vbat-1v8 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-boot-on;
> > > +		regulator-max-microvolt = <1800000>;
> > > +		regulator-min-microvolt = <1800000>;
> > > +		regulator-name = "vbat-1v8";
> > > +	};
> > > +
> > > +	reg_vbat_3v3: regulator-vbat-3v3 {
> > > +		compatible = "regulator-fixed";
> > > +		enable-active-high;
> > enable-active-high has no effect without a gpio.
> > 
> > > +		regulator-boot-on;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		regulator-min-microvolt = <3300000>;
> > > +		regulator-name = "vbat-3v3";
> > > +	};
> > Nothing can switch these two rails so regulator-always-on describes them
> > better than regulator-boot-on.
> 
> 
> I see. With the next version I will consider this. The regulator
> definitions are here only to prevent the hci driver form printing a
> message about missing regulator. Once we have the final regulators for
> the AON subsystem we should check this definitions and replace them if
> appropriate.

I looked at the schematic. VBAT is fed from VDD_3V3 and VDDIO from
DVDD18_AP, so I think the two regulators should be named after those
nets, something like this:

    reg_dvdd18_ap: regulator-dvdd18-ap {
            [..]
            regulator-name = "dvdd18_ap";
    };

    reg_vdd_3v3: regulator-vdd-3v3 {
            [..]
            regulator-name = "vdd_3v3";
    };

Thanks,
Drew
